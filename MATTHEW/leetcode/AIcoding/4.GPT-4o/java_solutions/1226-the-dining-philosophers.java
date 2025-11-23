import java.util.concurrent.Semaphore;

class DiningPhilosophers {
    private final Semaphore[] forks = new Semaphore[5];

    public DiningPhilosophers() {
        for (int i = 0; i < 5; i++) {
            forks[i] = new Semaphore(1);
        }
    }

    public void wantsToEat(int philosopher, Runnable pickForks, Runnable eat, Runnable putForks) throws InterruptedException {
        int leftFork = philosopher;
        int rightFork = (philosopher + 1) % 5;

        if (philosopher % 2 == 0) {
            forks[leftFork].acquire();
            forks[rightFork].acquire();
        } else {
            forks[rightFork].acquire();
            forks[leftFork].acquire();
        }

        pickForks.run();
        eat.run();
        putForks.run();

        forks[leftFork].release();
        forks[rightFork].release();
    }
}