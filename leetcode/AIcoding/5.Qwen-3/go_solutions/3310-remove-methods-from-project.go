package main

type Project struct {
	Methods map[string]bool
}

func removeMethodsFromProject(project *Project, methods []string) {
	for _, method := range methods {
		delete(project.Methods, method)
	}
}