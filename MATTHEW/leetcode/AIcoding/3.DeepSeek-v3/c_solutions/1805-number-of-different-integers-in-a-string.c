int numDifferentIntegers(char * word){
    int count = 0;
    char *nums[500];
    int num_count = 0;
    char *p = word;

    while (*p) {
        if (isdigit(*p)) {
            char *start = p;
            while (*p && isdigit(*p)) {
                p++;
            }
            char *end = p;

            while (start < end - 1 && *start == '0') {
                start++;
            }

            int len = end - start;
            char *num = (char*)malloc(len + 1);
            strncpy(num, start, len);
            num[len] = '\0';

            int found = 0;
            for (int i = 0; i < num_count; i++) {
                if (strcmp(nums[i], num) == 0) {
                    found = 1;
                    break;
                }
            }

            if (!found) {
                nums[num_count++] = num;
                count++;
            } else {
                free(num);
            }
        } else {
            p++;
        }
    }

    for (int i = 0; i < num_count; i++) {
        free(nums[i]);
    }

    return count;
}