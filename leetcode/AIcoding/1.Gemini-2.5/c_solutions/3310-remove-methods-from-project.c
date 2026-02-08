int removeMethods(int* projectMethods, int projectSize, int methodToRemoveId) {
    int k = 0;
    for (int i = 0; i < projectSize; i++) {
        if (projectMethods[i] != methodToRemoveId) {
            projectMethods[k] = projectMethods[i];
            k++;
        }
    }
    return k;
}