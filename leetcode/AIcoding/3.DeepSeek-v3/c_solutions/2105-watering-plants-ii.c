int minimumRefill(int* plants, int plantsSize, int capacityA, int capacityB) {
    int left = 0, right = plantsSize - 1;
    int canA = capacityA, canB = capacityB;
    int refills = 0;

    while (left <= right) {
        if (left == right) {
            if (canA >= canB) {
                if (canA < plants[left]) {
                    refills++;
                }
            } else {
                if (canB < plants[right]) {
                    refills++;
                }
            }
            break;
        }

        if (canA < plants[left]) {
            refills++;
            canA = capacityA;
        }
        canA -= plants[left];
        left++;

        if (canB < plants[right]) {
            refills++;
            canB = capacityB;
        }
        canB -= plants[right];
        right--;
    }

    return refills;
}