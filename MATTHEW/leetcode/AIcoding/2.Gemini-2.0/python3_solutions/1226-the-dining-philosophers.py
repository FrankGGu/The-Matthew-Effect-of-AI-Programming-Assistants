import threading

class DiningPhilosophers:
    def __init__(self):
        self.forks = [threading.Lock() for _ in range(5)]
        self.lock = threading.Lock()

    def wantsToEat(self, philosopher: int, pickLeftFork: callable, eat: callable, putRightFork: callable, putLeftFork: callable, pickRightFork: callable) -> None:
        left_fork = philosopher
        right_fork = (philosopher + 1) % 5

        with self.lock:
            pickLeftFork()
            self.forks[left_fork].acquire()
            pickRightFork()
            self.forks[right_fork].acquire()

            eat()

            putLeftFork()
            self.forks[left_fork].release()
            putRightFork()
            self.forks[right_fork].release()