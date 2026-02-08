import java.util.concurrent.Semaphore;

class Foo {

    private Semaphore firstSemaphore;
    private Semaphore secondSemaphore;

    public Foo() {
        firstSemaphore = new Semaphore(0);
        secondSemaphore = new Semaphore(0);
    }

    public void first(Runnable printFirst) throws InterruptedException {
        printFirst.run();
        firstSemaphore.release();
    }

    public void second(Runnable printSecond) throws InterruptedException {
        firstSemaphore.acquire();
        printSecond.run();
        secondSemaphore.release();
    }

    public void third(Runnable printThird) throws InterruptedException {
        secondSemaphore.acquire();
        printThird.run();
    }
}