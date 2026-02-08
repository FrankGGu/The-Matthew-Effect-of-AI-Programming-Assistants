class FooBar {
    constructor(n) {
        this.n = n;
        this.fooTurn = true;
        this.lock = new Promise(resolve => resolve());
    }

    async foo(printFoo) {
        for (let i = 0; i < this.n; i++) {
            await this.lock;
            printFoo();
            this.lock = new Promise(resolve => {
                this.resolveNext = resolve;
            });
            this.fooTurn = false;
        }
    }

    async bar(printBar) {
        for (let i = 0; i < this.n; i++) {
            while (this.fooTurn) {
                await new Promise(resolve => setTimeout(resolve, 0));
            }
            printBar();
            this.resolveNext();
            this.fooTurn = true;
        }
    }
}