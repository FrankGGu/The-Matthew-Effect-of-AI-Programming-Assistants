import threading

class H2O:
    def __init__(self):
        # Semaphores to control the number of available H and O atoms
        self.h_sem = threading.Semaphore(2)  # Allows 2 hydrogen atoms to proceed
        self.o_sem = threading.Semaphore(1)  # Allows 1 oxygen atom to proceed

        # Semaphores for threads to wait on before printing
        self.release_h = threading.Semaphore(0) # Hydrogen threads wait on this to print
        self.release_o = threading.Semaphore(0) # Oxygen threads wait on this to print

        # Lock to protect shared counters
        self.lock = threading.Lock()

        # Counters for atoms that have arrived at the synchronization point
        self.h_arrived = 0 
        self.o_arrived = 0 

    def hydrogen(self, releaseHydrogen: 'Callable[[], None]') -> None:
        # Acquire a slot for a hydrogen atom. Blocks if 2 H atoms are already in progress.
        self.h_sem.acquire() 

        self.lock.acquire()
        self.h_arrived += 1
        # Check if 2 H and 1 O atoms have arrived to form a molecule
        if self.h_arrived == 2 and self.o_arrived == 1:
            # If so, release all three atoms to print
            self.release_h.release() # Release first H
            self.release_h.release() # Release second H
            self.release_o.release() # Release O
            # Reset counters for the next molecule
            self.h_arrived = 0 
            self.o_arrived = 0
        self.lock.release()

        # Wait until this specific hydrogen atom is released to print
        self.release_h.acquire() 
        releaseHydrogen()
        # After printing, release the H slot for the next hydrogen atom
        self.h_sem.release() 

    def oxygen(self, releaseOxygen: 'Callable[[], None]') -> None:
        # Acquire a slot for an oxygen atom. Blocks if 1 O atom is already in progress.
        self.o_sem.acquire() 

        self.lock.acquire()
        self.o_arrived += 1
        # Check if 2 H and 1 O atoms have arrived to form a molecule
        if self.h_arrived == 2 and self.o_arrived == 1:
            # If so, release all three atoms to print
            self.release_h.release() # Release first H
            self.release_h.release() # Release second H
            self.release_o.release() # Release O
            # Reset counters for the next molecule
            self.h_arrived = 0 
            self.o_arrived = 0
        self.lock.release()

        # Wait until this specific oxygen atom is released to print
        self.release_o.acquire() 
        releaseOxygen()
        # After printing, release the O slot for the next oxygen atom
        self.o_sem.release()