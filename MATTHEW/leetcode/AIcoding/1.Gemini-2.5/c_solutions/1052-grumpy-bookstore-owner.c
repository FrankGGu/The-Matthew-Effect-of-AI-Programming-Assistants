int maxSatisfied(int* customers, int customersSize, int* grumpy, int grumpySize, int minutes) {
    int base_satisfied = 0;
    for (int i = 0; i < customersSize; i++) {
        if (grumpy[i] == 0) {
            base_satisfied += customers[i];
        }
    }

    int max_additional_satisfied = 0;
    int current_additional_satisfied = 0;

    for (int i = 0; i < minutes; i++) {
        if (grumpy[i] == 1) {
            current_additional_satisfied += customers[i];
        }
    }
    max_additional_satisfied = current_additional_satisfied;

    for (int i = minutes; i < customersSize; i++) {
        if (grumpy[i - minutes] == 1) {
            current_additional_satisfied -= customers[i - minutes];
        }
        if (grumpy[i] == 1) {
            current_additional_satisfied += customers[i];
        }
        if (current_additional_satisfied > max_additional_satisfied) {
            max_additional_satisfied = current_additional_satisfied;
        }
    }

    return base_satisfied + max_additional_satisfied;
}