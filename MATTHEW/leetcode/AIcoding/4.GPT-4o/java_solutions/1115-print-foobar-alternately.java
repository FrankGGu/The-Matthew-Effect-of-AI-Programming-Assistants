import java.util.concurrent.CountDownLatch;

class FooBar {
    private int n;
    private CountDownLatch fooLatch = new CountDownLatch(1);
    private CountDownLatch barLatch = new CountDownLatch(1);

    public FooBar(int n) {
        this.n = n;
    }

    public void foo(Runnable printFoo) throws InterruptedException {
        for (int i = 0; i < n; i++) {
            printFoo.run();
            fooLatch.countDown();
            barLatch.await();
            barLatch = new CountDownLatch(1);
        }
    }

    public void bar(Runnable printBar) throws InterruptedException {
        for (int i = 0; i < n; i++) {
            fooLatch.await();
            printBar.run();
            fooLatch = new CountDownLatch(1);
            barLatch.countDown();
        }
    }
}