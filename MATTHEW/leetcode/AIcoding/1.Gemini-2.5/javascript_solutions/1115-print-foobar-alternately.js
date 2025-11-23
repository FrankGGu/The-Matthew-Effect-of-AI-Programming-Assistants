class FooBar {
    constructor(n) {
        this.n = n;
        this.fooSignal = Promise.resolve();
        this.barSignal = new Promise(resolve => { this.barResolve = resolve; });
    }

    async foo(printFoo) {
        for (let i = 0; i < this.n; i++) {
            await this.fooSignal;
            printFoo();
            this.barResolve();
            this.fooSignal = new Promise(resolve => { this.fooResolve = resolve; });
        }
    }

    async bar(printBar) {
        for (let i = 0; i < this.n; i++) {
            await this.barSignal;
            printBar();
            this.fooResolve();
            this.barSignal = new Promise(resolve => { this.barResolve = resolve; });
        }
    }
}