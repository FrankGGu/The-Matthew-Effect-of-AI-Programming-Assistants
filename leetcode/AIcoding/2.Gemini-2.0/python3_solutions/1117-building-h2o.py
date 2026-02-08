import threading

class H2O:
    def __init__(self):
        self.hydrogen_count = 0
        self.hydrogen_lock = threading.Lock()
        self.oxygen_lock = threading.Lock()
        self.oxygen_ready = threading.Semaphore(0)
        self.hydrogen_ready = threading.Semaphore(0)

    def hydrogen(self, releaseHydrogen: 'Callable[[], None]') -> None:
        self.hydrogen_lock.acquire()
        self.hydrogen_count += 1
        releaseHydrogen()
        self.hydrogen_ready.release()
        if self.hydrogen_count == 2:
            self.oxygen_ready.release()
            self.oxygen_ready.release()
            self.hydrogen_count = 0
        self.hydrogen_lock.release()

    def oxygen(self, releaseOxygen: 'Callable[[], None]') -> None:
        self.oxygen_ready.acquire()
        releaseOxygen()
        self.hydrogen_ready.acquire()
        self.hydrogen_ready.acquire()