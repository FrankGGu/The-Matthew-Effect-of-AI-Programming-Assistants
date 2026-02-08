import threading

class FooBar:
    def __init__(self, n: int):
        self.n = n
        self.foo_lock = threading.Lock()
        self.bar_lock = threading.Lock()
        self.foo_lock.acquire()

    def foo(self, printFoo: 'Callable[[], None]') -> None:
        for _ in range(self.n):
            printFoo()
            self.bar_lock.release()
            self.foo_lock.acquire()

    def bar(self, printBar: 'Callable[[], None]') -> None:
        for _ in range(self.n):
            self.bar_lock.acquire()
            printBar()
            self.foo_lock.release()