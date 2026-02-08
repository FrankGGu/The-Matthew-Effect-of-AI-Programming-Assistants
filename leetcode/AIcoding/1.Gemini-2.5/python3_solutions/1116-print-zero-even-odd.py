import threading

class ZeroEvenOdd:
    def __init__(self, n):
        self.n = n
        self.s_zero = threading.Semaphore(1)
        self.s_odd = threading.Semaphore(0)
        self.s_even = threading.Semaphore(0)

    # printNumber(x) outputs "x", where x is an integer.
    def zero(self, printNumber: 'Callable[[int], None]') -> None:
        for i in range(1, self.n + 1):
            self.s_zero.acquire()
            printNumber(0)
            if i % 2 == 1:
                self.s_odd.release()
            else:
                self.s_even.release()

    def even(self, printNumber: 'Callable[[int], None]') -> None:
        for i in range(2, self.n + 1, 2):
            self.s_even.acquire()
            printNumber(i)
            self.s_zero.release()

    def odd(self, printNumber: 'Callable[[int], None]') -> None:
        for i in range(1, self.n + 1, 2):
            self.s_odd.acquire()
            printNumber(i)
            self.s_zero.release()