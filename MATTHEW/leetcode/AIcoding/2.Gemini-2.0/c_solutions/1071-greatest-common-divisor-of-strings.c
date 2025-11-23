#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int gcd(int a, int b) {
    if (b == 0) {
        return a;
    }
    return gcd(b, a % b);
}

char * gcdOfStrings(char * str1, char * str2){
    int len1 = strlen(str1);
    int len2 = strlen(str2);

    if (strcmp(str1, str2) == 0) {
        return str1;
    }

    if (strstr(str1, str2) != NULL)
    {
        int index = strstr(str1, str2) - str1;
        if (index == 0)
        {
            char* temp = str1;
            str1 = str2;
            str2 = temp;

            len1 = strlen(str1);
            len2 = strlen(str2);
        }
    }
    else if (strstr(str2, str1) != NULL)
    {
        int index = strstr(str2, str1) - str2;
        if (index == 0)
        {
            //do nothing
        }
        else
        {
            return "";
        }
    }
    else
    {
        if (strstr(str1, str2) == NULL && strstr(str2, str1) == NULL)
            {
                if(strcmp(strcat(strcpy((char*)malloc(len1+len2+1),str1),str2), strcat(strcpy((char*)malloc(len1+len2+1),str2),str1))!=0)
                {
                    return "";
                }
            }
    }

    if (strcmp(strcat(strcpy((char*)malloc(len1+len2+1),str1),str2), strcat(strcpy((char*)malloc(len1+len2+1),str2),str1))!=0)
    {
        return "";
    }

    int gcd_len = gcd(len1, len2);
    char *result = (char *)malloc(gcd_len + 1);
    strncpy(result, str1, gcd_len);
    result[gcd_len] = '\0';
    return result;
}