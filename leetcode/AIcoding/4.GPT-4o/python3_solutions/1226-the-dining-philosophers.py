import threading

class DiningPhilosophers:
    def __init__(self):
        self.lock = [threading.Lock() for _ in range(5)]

    def wantsToEat(self, philosopher: int, getLeftFork: 'Callable[[], None]', getRightFork: 'Callable[[], None]', eat: 'Callable[[], None]', putLeftFork: 'Callable[[], None]', putRightFork: 'Callable[[], None]') -> None:
        left = philosopher
        right = (philosopher + 1) % 5
        if philosopher % 2 == 0:
            self.lock[left].acquire()
            self.lock[right].acquire()
        else:
            self.lock[right].acquire()
            self.lock[left].acquire()
        getLeftFork()
        getRightFork()
        eat()
        putLeftFork()
        putRightFork()
        self.lock[left].release()
        self.lock[right].release()