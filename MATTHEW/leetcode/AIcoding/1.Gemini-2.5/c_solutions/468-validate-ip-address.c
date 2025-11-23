#include <stdbool.h>
#include <string.h>
#include <stdlib.h> // For atoi, strdup, free
#include <ctype.h>  // For isdigit, isxdigit

static bool isValidIPv4Segment(const char *segment) {
    if (segment == NULL || *segment == '\0') {
        return false; // Empty segment
    }
    int len = strlen(segment);
    if (len > 3 || len < 1) {
        return false; // Length constraint
    }
    if (len > 1 && segment[0] == '0') {
        return false; // Leading zero
    }
    // All characters must be digits (already checked by caller for overall string)
    // This loop is redundant if the caller already ensures only digits and delimiters.
    // However, it's safer to keep it for segment-level validation.
    for (int i = 0; i < len; i++) {
        if (!isdigit(segment[i])) {
            return false; // Non-digit character (should not happen if parent check is thorough)
        }
    }
    int num = atoi(segment);
    if (num < 0 || num > 255) {
        return false; // Value range
    }
    return true;
}

static bool isValidIPv6Segment(const char *segment) {
    if (segment == NULL || *segment == '\0') {
        return false; // Empty segment
    }
    int len = strlen(segment);
    if (len > 4 || len < 1) {
        return false; // Length constraint
    }
    // All characters must be hexadecimal digits (already checked by caller for overall string)
    // This loop is redundant if the caller already ensures only hex digits and delimiters.
    // However, it's safer to keep it for segment-level validation.
    for (int i = 0; i < len; i++) {
        if (!isxdigit(segment[i])) {
            return false; // Non-hexadecimal character (should not happen if parent check is thorough)
        }
    }
    return true;
}

static bool checkIPv4(char *IP) {
    int len = strlen(IP);
    int dot_count = 0;
    for (int i = 0; i < len; i++) {
        if (IP[i] == '.') {
            dot_count++;
        }
    }
    if (dot_count != 3) {
        return false; // Must have exactly 3 dots for 4 segments
    }

    // Check for leading/trailing dots or consecutive dots
    if (IP[0] == '.' || IP[len - 1] == '.') {
        return false;
    }
    for (int i = 0; i < len - 1; i++) {
        if (IP[i] == '.' && IP[i+1] == '.') {
            return false; // Consecutive dots imply empty segment
        }
    }

    // Use strtok to split and validate segments
    char *ip_copy = strdup(IP); // strtok modifies the string
    if (ip_copy == NULL) return false; // Memory allocation failed

    char *token = strtok(ip_copy, ".");
    int part_count = 0;
    bool valid = true;

    while (token != NULL) {
        if (!isValidIPv4Segment(token)) {
            valid = false;
            break;
        }
        part_count++;
        token = strtok(NULL, ".");
    }

    free(ip_copy);
    return valid && part_count == 4;
}

static bool checkIPv6(char *IP) {
    int len = strlen(IP);
    int colon_count = 0;
    for (int i = 0; i < len; i++) {
        if (IP[i] == ':') {
            colon_count++;
        }
    }
    if (colon_count != 7) {
        return false; // Must have exactly 7 colons for 8 segments
    }

    // Check for leading/trailing colons or consecutive colons
    if (IP[0] == ':' || IP[len - 1] == ':') {
        return false;
    }
    for (int i = 0; i < len - 1; i++) {
        if (IP[i] == ':' && IP[i+1] == ':') {
            return false; // Consecutive colons imply empty segment
        }
    }

    // Use strtok to split and validate segments
    char *ip_copy = strdup(IP); // strtok modifies the string
    if (ip_copy == NULL) return false; // Memory allocation failed

    char *token = strtok(ip_copy, ":");
    int part_count = 0;
    bool valid = true;

    while (token != NULL) {
        if (!isValidIPv6Segment(token)) {
            valid = false;
            break;
        }
        part_count++;
        token = strtok(NULL, ":");
    }

    free(ip_copy);
    return valid && part_count == 8;
}

char *validIPAddress(char *IP) {
    if (IP == NULL || *IP == '\0') {
        return "Neither";
    }

    bool has_dots = false;
    bool has_colons = false;
    for (int i = 0; IP[i] != '\0'; i++) {
        if (IP[i] == '.') {
            has_dots = true;
        } else if (IP[i] == ':') {
            has_colons = true;
        }
    }

    if (has_dots && has_colons) {
        return "Neither"; // Cannot be both IPv4 and IPv6
    } else if (has_dots) {
        // Potential IPv4: check all characters are digits or dots
        for (int i = 0; IP[i] != '\0'; i++) {
            if (!(isdigit(IP[i]) || IP[i] == '.')) {
                return "Neither"; // Contains invalid characters for IPv4
            }
        }
        if (checkIPv4(IP)) {
            return "IPv4";
        } else {
            return "Neither";
        }
    } else if (has_colons) {
        // Potential IPv6: check all characters are hex digits or colons
        for (int i = 0; IP[i] != '\0'; i++) {
            if (!(isxdigit(IP[i]) || IP[i] == ':')) {
                return "Neither"; // Contains invalid characters for IPv6
            }
        }
        if (checkIPv6(IP)) {
            return "IPv6";
        } else {
            return "Neither";
        }
    } else {
        // No dots or colons, cannot be a valid IP address
        return "Neither";
    }
}