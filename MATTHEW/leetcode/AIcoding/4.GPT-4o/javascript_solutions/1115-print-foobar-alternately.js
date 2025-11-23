class FooBar {
    constructor(n) {
        this.n = n;
        this.foo = true;
        this.bar = false;
        this.lock = new Promise((resolve) => { this.resolveFoo = resolve; });
    }

    async foo(printFoo) {
        for (let i = 0; i < this.n; i++) {
            await this.lock;
            printFoo(); 
            this.foo = false;
            this.bar = true;
            this.resolveFoo();
            this.lock = new Promise((resolve) => { this.resolveFoo = resolve; });
        }
    }

    async bar(printBar) {
        for (let i = 0; i < this.n; i++) {
            while (!this.bar) {
                await this.lock;
            }
            printBar();
            this.foo = true;
            this.bar = false;
            this.resolveFoo();
            this.lock = new Promise((resolve) => { this.resolveFoo = resolve; });
        }
    }
}