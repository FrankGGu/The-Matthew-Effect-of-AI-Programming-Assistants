import threading

class FizzBuzz:
    def __init__(self, n: int):
        self.n = n
        self.current_num = 1
        self.lock = threading.Lock()
        self.cond = threading.Condition(self.lock)

    def fizz(self, printFizz: 'Callable[[], None]') -> None:
        while True:
            with self.cond:
                while self.current_num <= self.n and (self.current_num % 3 != 0 or self.current_num % 5 == 0):
                    self.cond.wait()

                if self.current_num > self.n:
                    self.cond.notify_all()
                    break

                printFizz()
                self.current_num += 1
                self.cond.notify_all()

    def buzz(self, printBuzz: 'Callable[[], None]') -> None:
        while True:
            with self.cond:
                while self.current_num <= self.n and (self.current_num % 5 != 0 or self.current_num % 3 == 0):
                    self.cond.wait()

                if self.current_num > self.n:
                    self.cond.notify_all()
                    break

                printBuzz()
                self.current_num += 1
                self.cond.notify_all()

    def fizzbuzz(self, printFizzBuzz: 'Callable[[], None]') -> None:
        while True:
            with self.cond:
                while self.current_num <= self.n and self.current_num % 15 != 0:
                    self.cond.wait()

                if self.current_num > self.n:
                    self.cond.notify_all()
                    break

                printFizzBuzz()
                self.current_num += 1
                self.cond.notify_all()

    def number(self, printNumber: 'Callable[[int], None]') -> None:
        while True:
            with self.cond:
                while self.current_num <= self.n and (self.current_num % 3 == 0 or self.current_num % 5 == 0):
                    self.cond.wait()

                if self.current_num > self.n:
                    self.cond.notify_all()
                    break

                printNumber(self.current_num)
                self.current_num += 1
                self.cond.notify_all()