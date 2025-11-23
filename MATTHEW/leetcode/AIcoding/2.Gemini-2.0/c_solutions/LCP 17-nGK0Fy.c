#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int calculate(char* s) {
  int x = 1, y = 0;
  for (int i = 0; s[i] != '\0'; i++) {
    if (s[i] == 'A') {
      x = 2 * x + y;
    } else if (s[i] == 'B') {
      y = 2 * y + x;
    }
  }
  return x + y;
}