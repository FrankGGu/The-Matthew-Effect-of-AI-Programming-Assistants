type Router struct {
    routes map[string]string
}

func Constructor() Router {
    return Router{
        routes: make(map[string]string),
    }
}

func (this *Router) AddRoute(route string, result string) {
    this.routes[route] = result
}

func (this *Router) FindRoute(path string) string {
    if res, ok := this.routes[path]; ok {
        return res
    }
    return ""
}