public class Solution {

import java.util.concurrent.Semaphore;

public class H2O {
    private Semaphore hSemaphore = new Semaphore(2);
    private Semaphore oSemaphore = new Semaphore(1);

    public H2O() {}

    public void hydrogen(Runnable releaseHydrogen) throws InterruptedException {
        hSemaphore.acquire();
        releaseHydrogen.run();
        if (hSemaphore.availablePermits() == 0) {
            oSemaphore.release();
        }
    }

    public void oxygen(Runnable releaseOxygen) throws InterruptedException {
        oSemaphore.acquire();
        releaseOxygen.run();
        hSemaphore.release();
        hSemaphore.release();
    }
}
}