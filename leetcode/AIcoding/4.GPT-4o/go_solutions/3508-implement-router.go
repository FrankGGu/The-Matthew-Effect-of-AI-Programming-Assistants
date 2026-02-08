type Route struct {
    path string
    handler func() string
}

type Router struct {
    routes map[string]Route
}

func Constructor() Router {
    return Router{routes: make(map[string]Route)}
}

func (this *Router) AddRoute(path string, handler func() string) {
    this.routes[path] = Route{path: path, handler: handler}
}

func (this *Router) FindRoute(path string) (string, bool) {
    if route, exists := this.routes[path]; exists {
        return route.handler(), true
    }
    return "", false
}