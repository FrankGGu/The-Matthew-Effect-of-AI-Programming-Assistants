import java.util.concurrent.Semaphore;

class H2O {

    private Semaphore hReady; // Signals that a hydrogen atom is ready
    private Semaphore oReady; // Signals that an oxygen atom is ready to allow hydrogens to release

    public H2O() {
        hReady = new Semaphore(0); // Initially no hydrogen atoms are ready
        oReady = new Semaphore(0); // Initially no oxygen atom is ready
    }

    public void hydrogen(Runnable releaseHydrogen) throws InterruptedException {
        hReady.release(); 

        oReady.acquire(); 

        releaseHydrogen.run();
    }

    public void oxygen(Runnable releaseOxygen) throws InterruptedException {
        hReady.acquire(); 
        hReady.acquire(); 

        releaseOxygen.run();

        oReady.release(); 
        oReady.release(); 
    }
}