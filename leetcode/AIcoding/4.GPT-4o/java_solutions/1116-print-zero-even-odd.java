import java.util.concurrent.CountDownLatch;

public class ZeroEvenOdd {
    private int n;
    private CountDownLatch zeroLatch = new CountDownLatch(1);
    private CountDownLatch evenLatch = new CountDownLatch(1);

    public ZeroEvenOdd(int n) {
        this.n = n;
    }

    // printNumber(x) outputs "x", where x is an integer.
    public void zero(Runnable printNumber) throws InterruptedException {
        for (int i = 0; i < n; i++) {
            printNumber.run();
            zeroLatch.countDown();
            if (i % 2 == 0) {
                evenLatch.countDown();
            } else {
                zeroLatch = new CountDownLatch(1);
            }
            zeroLatch.await();
        }
    }

    public void even(Runnable printNumber) throws InterruptedException {
        for (int i = 2; i <= n; i += 2) {
            evenLatch.await();
            printNumber.run();
            zeroLatch.countDown();
            evenLatch = new CountDownLatch(1);
        }
    }

    public void odd(Runnable printNumber) throws InterruptedException {
        for (int i = 1; i <= n; i += 2) {
            zeroLatch.await();
            printNumber.run();
            zeroLatch = new CountDownLatch(1);
        }
    }
}