import (
	"strings"
)

func maskPII(s string) string {
	if strings.Contains(s, "@") {
		parts := strings.Split(s, "@")
		return strings.ToLower(string(parts[0][0])) + "*****" + strings.ToLower(string(parts[0][len(parts[0])-1])) + "@" + strings.ToLower(parts[1])
	} else {
		digits := ""
		for _, char := range s {
			if char >= '0' && char <= '9' {
				digits += string(char)
			}
		}
		local := digits[len(digits)-4:]
		if len(digits) == 10 {
			return "***-***-" + local
		} else if len(digits) == 11 {
			return "+*-***-***-" + local
		} else if len(digits) == 12 {
			return "+**-***-***-" + local
		} else {
			return "+***-***-***-" + local
		}
	}
}