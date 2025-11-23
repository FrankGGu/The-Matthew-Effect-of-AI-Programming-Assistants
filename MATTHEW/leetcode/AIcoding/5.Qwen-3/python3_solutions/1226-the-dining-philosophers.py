from threading import Lock

class DiningPhilosophers:
    def __init__(self):
        self.forks = [Lock() for _ in range(5)]

    def wantsToEat(self,
                   philosopher: int,
                   pickLeftFork: 'Callable[[], None]',
                   pickRightFork: 'Callable[[], None]',
                   eat: 'Callable[[], None]',
                   putLeftFork: 'Callable[[], None]',
                   putRightFork: 'Callable[[], None]') -> None:
        left = philosopher
        right = (philosopher + 1) % 5
        if philosopher % 2 == 0:
            self.forks[left].acquire()
            pickLeftFork()
            self.forks[right].acquire()
            pickRightFork()
        else:
            self.forks[right].acquire()
            pickRightFork()
            self.forks[left].acquire()
            pickLeftFork()
        eat()
        self.forks[left].release()
        putLeftFork()
        self.forks[right].release()
        putRightFork()