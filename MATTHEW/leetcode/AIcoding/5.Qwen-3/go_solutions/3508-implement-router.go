package main

type Route struct {
    handler func(string) string
}

type Router struct {
    routes map[string]*Route
}

func NewRouter() *Router {
    return &Router{
        routes: make(map[string]*Route),
    }
}

func (r *Router) AddRoute(method string, path string, handler func(string) string) {
    key := method + ":" + path
    r.routes[key] = &Route{handler: handler}
}

func (r *Router) HandleRequest(method string, path string, input string) string {
    key := method + ":" + path
    route, exists := r.routes[key]
    if !exists {
        return "404 Not Found"
    }
    return route.handler(input)
}