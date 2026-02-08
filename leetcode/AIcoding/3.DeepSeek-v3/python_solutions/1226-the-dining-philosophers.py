import threading

class DiningPhilosophers:
    def __init__(self):
        self.locks = [threading.Lock() for _ in range(5)]

    def wantsToEat(self, philosopher, pickLeftFork, pickRightFork, putLeftFork, putRightFork, *actions):
        left = philosopher
        right = (philosopher + 1) % 5

        if philosopher % 2 == 0:
            first, second = left, right
        else:
            first, second = right, left

        with self.locks[first]:
            with self.locks[second]:
                pickLeftFork()
                pickRightFork()
                for _ in range(4):
                    next(actions)
                putLeftFork()
                putRightFork()