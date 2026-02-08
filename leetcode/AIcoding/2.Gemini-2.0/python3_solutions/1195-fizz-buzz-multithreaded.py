import threading

class FizzBuzz:
    def __init__(self, n):
        self.n = n
        self.number = 1
        self.lock = threading.Lock()
        self.fizz_event = threading.Event()
        self.buzz_event = threading.Event()
        self.fizzbuzz_event = threading.Event()
        self.number_event = threading.Event()
        self.number_event.set()

    def fizz(self, printFizz):
        while self.number <= self.n:
            self.fizz_event.wait()
            with self.lock:
                if self.number > self.n:
                    break
                printFizz()
                self.number += 1
                self.number_event.set()
            self.fizz_event.clear()

    def buzz(self, printBuzz):
        while self.number <= self.n:
            self.buzz_event.wait()
            with self.lock:
                if self.number > self.n:
                    break
                printBuzz()
                self.number += 1
                self.number_event.set()
            self.buzz_event.clear()

    def fizzbuzz(self, printFizzBuzz):
        while self.number <= self.n:
            self.fizzbuzz_event.wait()
            with self.lock:
                if self.number > self.n:
                    break
                printFizzBuzz()
                self.number += 1
                self.number_event.set()
            self.fizzbuzz_event.clear()

    def number(self, printNumber):
        while self.number <= self.n:
            self.number_event.wait()
            with self.lock:
                if self.number > self.n:
                    break
                printNumber(self.number)
                self.number += 1
                if self.number % 3 == 0 and self.number % 5 == 0:
                    self.fizzbuzz_event.set()
                elif self.number % 3 == 0:
                    self.fizz_event.set()
                elif self.number % 5 == 0:
                    self.buzz_event.set()
                else:
                    self.number_event.set()
            self.number_event.clear()