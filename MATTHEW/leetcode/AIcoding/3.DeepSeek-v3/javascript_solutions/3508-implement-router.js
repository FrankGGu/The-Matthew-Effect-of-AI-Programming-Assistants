class Router {
    constructor() {
        this.routes = {};
    }

    add(path, handler) {
        this.routes[path] = handler;
    }

    navigate(path) {
        const handler = this.routes[path];
        if (handler) {
            handler();
        } else {
            console.log("404 Not Found");
        }
    }
}