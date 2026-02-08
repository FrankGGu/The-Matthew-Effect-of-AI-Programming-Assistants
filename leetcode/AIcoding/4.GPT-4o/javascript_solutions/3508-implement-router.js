class Router {
    constructor() {
        this.routes = {};
    }

    addRoute(path, handler) {
        this.routes[path] = handler;
    }

    get(path) {
        return this.routes[path] || null;
    }
}

const router = new Router();
router.addRoute('/home', () => 'Home');
router.addRoute('/about', () => 'About');
()); // Output: Home
()); // Output: About
); // Output: null