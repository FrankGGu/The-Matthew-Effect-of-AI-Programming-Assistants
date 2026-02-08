import threading

class Foo:
    def __init__(self):
        self.second = threading.Event()
        self.third = threading.Event()

    def first(self, printFirst: 'Callable') -> None:
        printFirst()
        self.second.set()

    def second(self, printSecond: 'Callable') -> None:
        self.second.wait()
        printSecond()
        self.third.set()

    def third(self, printThird: 'Callable') -> None:
        self.third.wait()
        printThird()