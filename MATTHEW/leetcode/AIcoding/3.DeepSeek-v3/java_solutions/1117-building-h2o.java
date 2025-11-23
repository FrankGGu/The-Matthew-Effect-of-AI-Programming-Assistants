import java.util.concurrent.*;

class H2O {
    private Semaphore hydrogenSemaphore;
    private Semaphore oxygenSemaphore;
    private CyclicBarrier barrier;

    public H2O() {
        hydrogenSemaphore = new Semaphore(2);
        oxygenSemaphore = new Semaphore(1);
        barrier = new CyclicBarrier(3);
    }

    public void hydrogen(Runnable releaseHydrogen) throws InterruptedException {
        hydrogenSemaphore.acquire();
        try {
            barrier.await();
        } catch (BrokenBarrierException | InterruptedException e) {
            throw new RuntimeException(e);
        }
        releaseHydrogen.run();
        hydrogenSemaphore.release();
    }

    public void oxygen(Runnable releaseOxygen) throws InterruptedException {
        oxygenSemaphore.acquire();
        try {
            barrier.await();
        } catch (BrokenBarrierException | InterruptedException e) {
            throw new RuntimeException(e);
        }
        releaseOxygen.run();
        oxygenSemaphore.release();
    }
}