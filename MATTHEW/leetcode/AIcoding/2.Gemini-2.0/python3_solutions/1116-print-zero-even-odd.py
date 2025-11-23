from threading import Lock, Condition

class ZeroEvenOdd:
    def __init__(self, n):
        self.n = n
        self.zero_lock = Lock()
        self.even_lock = Lock()
        self.odd_lock = Lock()
        self.even_lock.acquire()
        self.odd_lock.acquire()
        self.num = 1

    def zero(self, printNumber):
        for _ in range(self.n):
            self.zero_lock.acquire()
            printNumber(0)
            if self.num % 2 == 0:
                self.even_lock.release()
            else:
                self.odd_lock.release()

    def even(self, printNumber):
        while self.num <= self.n:
            self.even_lock.acquire()
            if self.num > self.n:
                self.zero_lock.release()
                break
            printNumber(self.num)
            self.num += 1
            self.zero_lock.release()

    def odd(self, printNumber):
        while self.num <= self.n:
            self.odd_lock.acquire()
            if self.num > self.n:
                self.zero_lock.release()
                break
            printNumber(self.num)
            self.num += 1
            self.zero_lock.release()