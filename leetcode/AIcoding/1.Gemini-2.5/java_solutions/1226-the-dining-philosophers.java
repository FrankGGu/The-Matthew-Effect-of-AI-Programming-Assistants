import java.util.concurrent.Semaphore;
import java.util.concurrent.locks.ReentrantLock;

class DiningPhilosophers {

    private ReentrantLock[] chopsticks;
    private Semaphore limit;

    public DiningPhilosophers() {
        chopsticks = new ReentrantLock[5];
        for (int i = 0; i < 5; i++) {
            chopsticks[i] = new ReentrantLock();
        }
        limit = new Semaphore(4); 
    }

    public void wantsToEat(int philosopher,
                           Runnable pickLeftChopstick,
                           Runnable pickRightChopstick,
                           Runnable eat,
                           Runnable putLeftChopstick,
                           Runnable putRightChopstick) throws InterruptedException {

        int leftChopstick = philosopher;
        int rightChopstick = (philosopher + 1) % 5;

        limit.acquire();

        chopsticks[leftChopstick].lock();
        pickLeftChopstick.run();

        chopsticks[rightChopstick].lock();
        pickRightChopstick.run();

        eat.run();

        chopsticks[rightChopstick].unlock();
        putRightChopstick.run();

        chopsticks[leftChopstick].unlock();
        putLeftChopstick.run();

        limit.release();
    }
}