int g_max;

void backtrack(int* materials, int materialsSize, int** cookbooks, int cookbooksSize, int* cookbooksColSize, int** attribute, int attributeSize, int* attributeColSize, int limit, int idx, int delicious, int full) {
    if (full >= limit) {
        if (delicious > g_max) {
            g_max = delicious;
        }
    }
    if (idx == cookbooksSize) {
        return;
    }

    backtrack(materials, materialsSize, cookbooks, cookbooksSize, cookbooksColSize, attribute, attributeSize, attributeColSize, limit, idx + 1, delicious, full);

    int* newMaterials = (int*)malloc(materialsSize * sizeof(int));
    for (int i = 0; i < materialsSize; i++) {
        newMaterials[i] = materials[i] - cookbooks[idx][i];
        if (newMaterials[i] < 0) {
            free(newMaterials);
            return;
        }
    }

    backtrack(newMaterials, materialsSize, cookbooks, cookbooksSize, cookbooksColSize, attribute, attributeSize, attributeColSize, limit, idx + 1, delicious + attribute[idx][0], full + attribute[idx][1]);
    free(newMaterials);
}

int perfectMenu(int* materials, int materialsSize, int** cookbooks, int cookbooksSize, int* cookbooksColSize, int** attribute, int attributeSize, int* attributeColSize, int limit) {
    g_max = -1;
    backtrack(materials, materialsSize, cookbooks, cookbooksSize, cookbooksColSize, attribute, attributeSize, attributeColSize, limit, 0, 0, 0);
    return g_max;
}