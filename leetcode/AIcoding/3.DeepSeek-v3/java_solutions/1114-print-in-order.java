class Foo {
    private boolean firstDone;
    private boolean secondDone;
    private final Object lock = new Object();

    public Foo() {
        firstDone = false;
        secondDone = false;
    }

    public void first(Runnable printFirst) throws InterruptedException {
        synchronized (lock) {
            printFirst.run();
            firstDone = true;
            lock.notifyAll();
        }
    }

    public void second(Runnable printSecond) throws InterruptedException {
        synchronized (lock) {
            while (!firstDone) {
                lock.wait();
            }
            printSecond.run();
            secondDone = true;
            lock.notifyAll();
        }
    }

    public void third(Runnable printThird) throws InterruptedException {
        synchronized (lock) {
            while (!secondDone) {
                lock.wait();
            }
            printThird.run();
        }
    }
}