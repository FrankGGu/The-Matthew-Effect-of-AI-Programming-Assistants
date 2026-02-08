import threading

class DiningPhilosophers:
    def __init__(self):
        self.forks = [threading.Lock() for _ in range(5)]
        self.limit = threading.Semaphore(4)

    def wantsToEat(self,
                   philosopher: int,
                   pickLeftFork: 'Callable[[], None]',
                   pickRightFork: 'Callable[[], None]',
                   eat: 'Callable[[], None]',
                   putLeftFork: 'Callable[[], None]',
                   putRightFork: 'Callable[[], None]') -> None:

        left_fork_idx = philosopher
        right_fork_idx = (philosopher + 1) % 5

        self.limit.acquire()

        self.forks[left_fork_idx].acquire()
        self.forks[right_fork_idx].acquire()

        pickLeftFork()
        pickRightFork()
        eat()
        putLeftFork()
        putRightFork()

        self.forks[right_fork_idx].release()
        self.forks[left_fork_idx].release()

        self.limit.release()