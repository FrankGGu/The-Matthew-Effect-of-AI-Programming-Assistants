function removeMethods(project) {
    return project.filter(method => !method.startsWith('remove'));
}