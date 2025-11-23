class DiningPhilosophers {
    constructor() {
        this.forks = Array(5).fill().map(() => new Promise(resolve => resolve()));
        this.lock = new Promise(resolve => resolve());
    }

    async pickLeftFork(i) {
        await this.forks[i];
        this.forks[i] = new Promise(resolve => resolve());
    }

    async pickRightFork(i) {
        await this.forks[(i + 1) % 5];
        this.forks[(i + 1) % 5] = new Promise(resolve => resolve());
    }

    async putLeftFork(i) {
        this.forks[i] = new Promise(resolve => resolve());
    }

    async putRightFork(i) {
        this.forks[(i + 1) % 5] = new Promise(resolve => resolve());
    }

    async eat(i) {
        const left = i;
        const right = (i + 1) % 5;
        const firstFork = Math.min(left, right);
        const secondFork = Math.max(left, right);

        await this.lock;
        await this.forks[firstFork];
        await this.forks[secondFork];
        this.lock = new Promise(resolve => resolve());

        await this.pickLeftFork(i);
        await this.pickRightFork(i);
        await this.putLeftFork(i);
        await this.putRightFork(i);
    }
}