class Router {
    constructor() {
        this.routes = [];
    }

    add(path, handler) {
        const paramNames = [];
        const regexPath = path.replace(/:([a-zA-Z0-9_]+)/g, (match, paramName) => {
            paramNames.push(paramName);
            return '([^/]+)';
        });

        const regex = new RegExp(`^${regexPath}$`);
        this.routes.push({ regex, handler, paramNames });
    }

    resolve(path) {
        for (const route of this.routes) {
            const match = path.match(route.regex);
            if (match) {
                const params = {};
                for (let i = 0; i < route.paramNames.length; i++) {
                    params[route.paramNames[i]] = match[i + 1];
                }
                return route.handler(params);
            }
        }
        return null;
    }
}