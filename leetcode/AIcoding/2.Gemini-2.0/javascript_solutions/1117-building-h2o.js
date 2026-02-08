class H2O {
    constructor() {
        this.hydrogen = 0;
        this.oxygen = 0;
        this.lock = new Promise(resolve => this.resolver = resolve);
    }

    hydrogen(releaseHydrogen) {
        this.lock.then(() => {
            this.hydrogen++;
            if (this.hydrogen === 2 && this.oxygen === 1) {
                releaseHydrogen();
                releaseHydrogen();
                this.resolver();
                this.hydrogen = 0;
                this.oxygen = 0;
                this.lock = new Promise(resolve => this.resolver = resolve);
            } else {
                releaseHydrogen();
                this.resolver();
                this.lock = new Promise(resolve => this.resolver = resolve);
            }
        });
        return new Promise(resolve => resolve());
    }

    oxygen(releaseOxygen) {
        this.lock.then(() => {
            this.oxygen++;
            if (this.hydrogen === 2 && this.oxygen === 1) {
                releaseOxygen();
                this.resolver();
                releaseOxygen();
                this.resolver();
                this.hydrogen = 0;
                this.oxygen = 0;
                this.lock = new Promise(resolve => this.resolver = resolve);
            } else {
                releaseOxygen();
                this.resolver();
                this.lock = new Promise(resolve => this.resolver = resolve);
            }
        });
        return new Promise(resolve => resolve());
    }
}