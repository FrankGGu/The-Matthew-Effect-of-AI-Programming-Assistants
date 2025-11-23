#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int solve() {
    char dynasty[20];
    scanf("%s", dynasty);

    if (strcmp(dynasty, "Xia") == 0) return -2100;
    if (strcmp(dynasty, "Shang") == 0) return -1600;
    if (strcmp(dynasty, "Zhou") == 0) return -1046;
    if (strcmp(dynasty, "Qin") == 0) return -221;
    if (strcmp(dynasty, "Han") == 0) return -206;
    if (strcmp(dynasty, "Wei") == 0) return 220;
    if (strcmp(dynasty, "Jin") == 0) return 266;
    if (strcmp(dynasty, "Sui") == 0) return 581;
    if (strcmp(dynasty, "Tang") == 0) return 618;
    if (strcmp(dynasty, "Song") == 0) return 960;
    if (strcmp(dynasty, "Yuan") == 0) return 1271;
    if (strcmp(dynasty, "Ming") == 0) return 1368;
    if (strcmp(dynasty, "Qing") == 0) return 1644;

    return 0;
}