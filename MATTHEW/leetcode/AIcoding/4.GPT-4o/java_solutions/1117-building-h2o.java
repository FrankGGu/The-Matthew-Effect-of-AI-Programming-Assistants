import java.util.concurrent.CountDownLatch;
import java.util.concurrent.Semaphore;

class H2O {
    private Semaphore hSemaphore = new Semaphore(2);
    private Semaphore oSemaphore = new Semaphore(1);
    private CountDownLatch countDownLatch = new CountDownLatch(3);

    public H2O() {
    }

    public void hydrogen(Runnable releaseHydrogen) throws InterruptedException {
        hSemaphore.acquire();
        releaseHydrogen.run();
        countDownLatch.countDown();
        if (countDownLatch.getCount() == 0) {
            oSemaphore.release();
        }
        hSemaphore.release();
    }

    public void oxygen(Runnable releaseOxygen) throws InterruptedException {
        oSemaphore.acquire();
        releaseOxygen.run();
        countDownLatch.countDown();
        hSemaphore.release(2);
        oSemaphore.release();
    }
}