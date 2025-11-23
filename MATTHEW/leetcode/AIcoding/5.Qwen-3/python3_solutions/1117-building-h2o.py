from threading import Barrier, Semaphore

class H2O:
    def __init__(self):
        self.hydrogen_semaphore = Semaphore(2)
        self.oxygen_semaphore = Semaphore(1)
        self.barrier = Barrier(3)

    def hydrogen(self, releaseHydrogen: 'Callable[[], None]') -> None:
        self.hydrogen_semaphore.acquire()
        releaseHydrogen()
        self.barrier.wait()
        self.hydrogen_semaphore.release()

    def oxygen(self, releaseOxygen: 'Callable[[], None]') -> None:
        self.oxygen_semaphore.acquire()
        releaseOxygen()
        self.barrier.wait()
        self.oxygen_semaphore.release()