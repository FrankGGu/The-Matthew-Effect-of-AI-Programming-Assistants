#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int distMoney(int money, int children){
    if(money < children) return -1;
    money -= children;
    int ans = money / 7;
    if(ans > children) return children - 1;
    int rem = money % 7;
    if(ans == children - 1 && rem == 3) return ans - 1;
    return ans;
}