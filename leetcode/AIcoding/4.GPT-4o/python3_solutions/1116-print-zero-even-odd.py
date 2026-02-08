import threading

class ZeroEvenOdd:
    def __init__(self, n: int):
        self.n = n
        self.zero_lock = threading.Lock()
        self.even_lock = threading.Lock()
        self.odd_lock = threading.Lock()
        self.even_lock.acquire()
        self.odd_lock.acquire()

    def zero(self, printNumber: 'Callable[[], None]') -> None:
        for i in range(self.n):
            self.zero_lock.acquire()
            printNumber()
            if i % 2 == 0:
                self.even_lock.release()
            else:
                self.odd_lock.release()

    def odd(self, printNumber: 'Callable[[], None]') -> None:
        for i in range(1, self.n + 1, 2):
            self.odd_lock.acquire()
            printNumber()
            self.zero_lock.release()

    def even(self, printNumber: 'Callable[[], None]') -> None:
        for i in range(2, self.n + 1, 2):
            self.even_lock.acquire()
            printNumber()
            self.zero_lock.release()