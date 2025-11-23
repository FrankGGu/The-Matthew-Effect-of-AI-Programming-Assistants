import threading

class H2O:
    def __init__(self):
        self.h_count = 0
        self.lock = threading.Lock()
        self.h_cond = threading.Condition(self.lock)
        self.o_cond = threading.Condition(self.lock)

    def hydrogen(self, releaseHydrogen: 'Callable[[], None]') -> None:
        with self.lock:
            self.h_count += 1
            if self.h_count == 2:
                self.o_cond.notify()
            self.h_cond.wait()
            releaseHydrogen()

    def oxygen(self, releaseOxygen: 'Callable[[], None]') -> None:
        with self.lock:
            self.o_cond.wait()
            self.h_count = 0
            releaseOxygen()
            self.h_cond.notify_all()