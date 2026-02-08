import java.util.concurrent.locks.ReentrantLock;
import java.util.concurrent.Semaphore;

class DiningPhilosophers {

    private ReentrantLock[] forks = new ReentrantLock[5];
    private Semaphore eatLimit = new Semaphore(4);

    public DiningPhilosophers() {
        for (int i = 0; i < 5; i++) {
            forks[i] = new ReentrantLock();
        }
    }

    public void wantsToEat(int philosopher,
                            Runnable pickLeftFork,
                            Runnable pickRightFork,
                            Runnable eat,
                            Runnable putLeftFork,
                            Runnable putRightFork) throws InterruptedException {

        eatLimit.acquire();

        int leftFork = philosopher;
        int rightFork = (philosopher + 1) % 5;

        try {
            forks[leftFork].lock();
            pickLeftFork.run();

            forks[rightFork].lock();
            pickRightFork.run();

            eat.run();

            putLeftFork.run();
            forks[leftFork].unlock();

            putRightFork.run();
            forks[rightFork].unlock();

        } finally {
            eatLimit.release();
        }
    }
}