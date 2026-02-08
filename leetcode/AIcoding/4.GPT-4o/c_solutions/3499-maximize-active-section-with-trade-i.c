int maxActiveSections(int* sections, int sectionsSize, int trade) {
    int max_active = 0;
    for (int i = 0; i < sectionsSize; i++) {
        int current_active = 0;
        for (int j = i; j < sectionsSize; j++) {
            current_active += sections[j];
            if (current_active > trade) {
                break;
            }
            max_active++;
        }
    }
    return max_active;
}