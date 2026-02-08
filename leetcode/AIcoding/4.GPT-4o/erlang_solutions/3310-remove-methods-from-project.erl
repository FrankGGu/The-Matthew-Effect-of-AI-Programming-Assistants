-module(solution).
-export([remove_methods/2]).

remove_methods(Project, Methods) ->
    MethodsSet = sets:from_list(Methods),
    lists:filter(fun(Method) -> not sets:is_element(Method, MethodsSet) end, Project).