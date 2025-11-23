import java.util.concurrent.*;
class FizzBuzz {
    private int n;
    private Semaphore fizzSem = new Semaphore(0);
    private Semaphore buzzSem = new Semaphore(0);
    private Semaphore fizzBuzzSem = new Semaphore(0);
    private Semaphore numberSem = new Semaphore(1);
    private int current = 1;

    public FizzBuzz(int n) {
        this.n = n;
    }

    public void fizz(Runnable printFizz) throws InterruptedException {
        while (current <= n) {
            fizzSem.acquire();
            if (current > n) break;
            printFizz.run();
            numberSem.release();
        }
    }

    public void buzz(Runnable printBuzz) throws InterruptedException {
        while (current <= n) {
            buzzSem.acquire();
            if (current > n) break;
            printBuzz.run();
            numberSem.release();
        }
    }

    public void fizzbuzz(Runnable printFizzBuzz) throws InterruptedException {
        while (current <= n) {
            fizzBuzzSem.acquire();
            if (current > n) break;
            printFizzBuzz.run();
            numberSem.release();
        }
    }

    public void number(IntConsumer printNumber) throws InterruptedException {
        while (current <= n) {
            numberSem.acquire();
            if (current > n) {
                fizzSem.release();
                buzzSem.release();
                fizzBuzzSem.release();
                break;
            }
            if (current % 3 == 0 && current % 5 == 0) {
                fizzBuzzSem.release();
            } else if (current % 3 == 0) {
                fizzSem.release();
            } else if (current % 5 == 0) {
                buzzSem.release();
            } else {
                printNumber.accept(current);
                numberSem.release();
            }
            current++;
        }
    }
}