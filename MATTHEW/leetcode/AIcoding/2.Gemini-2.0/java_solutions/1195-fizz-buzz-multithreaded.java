import java.util.function.IntConsumer;

class FizzBuzz {
    private int n;
    private int i = 1;

    public FizzBuzz(int n) {
        this.n = n;
    }

    public synchronized void fizz(Runnable printFizz) throws InterruptedException {
        while (i <= n) {
            if (i % 3 == 0 && i % 5 != 0) {
                printFizz.run();
                i++;
                notifyAll();
            } else {
                wait();
            }
        }
    }

    public synchronized void buzz(Runnable printBuzz) throws InterruptedException {
        while (i <= n) {
            if (i % 3 != 0 && i % 5 == 0) {
                printBuzz.run();
                i++;
                notifyAll();
            } else {
                wait();
            }
        }
    }

    public synchronized void fizzbuzz(Runnable printFizzBuzz) throws InterruptedException {
        while (i <= n) {
            if (i % 3 == 0 && i % 5 == 0) {
                printFizzBuzz.run();
                i++;
                notifyAll();
            } else {
                wait();
            }
        }
    }

    public synchronized void number(IntConsumer printNumber) throws InterruptedException {
        while (i <= n) {
            if (i % 3 != 0 && i % 5 != 0) {
                printNumber.accept(i);
                i++;
                notifyAll();
            } else {
                wait();
            }
        }
    }
}