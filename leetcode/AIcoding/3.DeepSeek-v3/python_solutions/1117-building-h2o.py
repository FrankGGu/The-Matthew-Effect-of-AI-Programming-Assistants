from threading import Semaphore

class H2O:
    def __init__(self):
        self.h_sem = Semaphore(2)
        self.o_sem = Semaphore(0)
        self.h_count = 0

    def hydrogen(self, releaseHydrogen: 'Callable[[], None]') -> None:
        self.h_sem.acquire()
        releaseHydrogen()
        self.h_count += 1
        if self.h_count == 2:
            self.o_sem.release()
            self.h_count = 0

    def oxygen(self, releaseOxygen: 'Callable[[], None]') -> None:
        self.o_sem.acquire()
        releaseOxygen()
        self.h_sem.release()
        self.h_sem.release()