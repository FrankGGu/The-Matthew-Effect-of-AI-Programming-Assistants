class Router {
  constructor() {
    this.routes = {};
  }

  addRoute(path, handler) {
    this.routes[path] = handler;
  }

  route(path) {
    if (this.routes[path]) {
      return this.routes[path]();
    } else {
      return '404 Not Found';
    }
  }
}