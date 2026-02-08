public class Solution {

import java.util.concurrent.CountDownLatch;

public class Solution {
    private CountDownLatch firstLatch = new CountDownLatch(1);
    private CountDownLatch secondLatch = new CountDownLatch(1);

    public void first(Runnable printFirst) throws InterruptedException {
        printFirst.run();
        firstLatch.countDown();
    }

    public void second(Runnable printSecond) throws InterruptedException {
        firstLatch.await();
        printSecond.run();
        secondLatch.countDown();
    }

    public void third(Runnable printThird) throws InterruptedException {
        secondLatch.await();
        printThird.run();
    }
}
}