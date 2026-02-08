class H2O {
    constructor() {
        this.hQueue = [];
        this.oQueue = [];
    }

    hydrogen(releaseHydrogen) {
        this.hQueue.push(releaseHydrogen);
        this.tryFormMolecule();
    }

    oxygen(releaseOxygen) {
        this.oQueue.push(releaseOxygen);
        this.tryFormMolecule();
    }

    tryFormMolecule() {
        while (this.hQueue.length >= 2 && this.oQueue.length >= 1) {
            const h1 = this.hQueue.shift();
            const h2 = this.hQueue.shift();
            const o = this.oQueue.shift();

            h1();
            h2();
            o();
        }
    }
}