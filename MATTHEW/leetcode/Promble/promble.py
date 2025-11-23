import requests
import json
import os
from datetime import datetime

# Updated GraphQL endpoint
GRAPHQL_URL = "https://leetcode.cn/graphql/"  # Using Chinese mirror site

# Enhanced request headers
HEADERS = {
    "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36",
    "Content-Type": "application/json",
    "Referer": "https://leetcode.cn/problemset/all/",
    "Origin": "https://leetcode.cn",
    "x-csrftoken": "fetch"  # CSRF token required
}

# Corrected GraphQL query template
QUESTION_LIST_QUERY = """
query problemsetQuestionList($categorySlug: String, $limit: Int, $skip: Int, $filters: QuestionListFilterInput) {
  problemsetQuestionList(
    categorySlug: $categorySlug
    limit: $limit
    skip: $skip
    filters: $filters
  ) {
    total
    questions {
      acRate
      difficulty
      freqBar
      frontendQuestionId
      isFavor
      paidOnly
      solutionNum
      status
      title
      titleCn
      titleSlug
      topicTags {
        name
        nameTranslated
        id
        slug
      }
      extra {
        hasVideoSolution
        topCompanyTags {
          imgUrl
          slug
          numSubscribed
        }
      }
    }
  }
}
"""

# Get all problem list (corrected version)
def get_all_problems():
    problems = []
    page = 0
    limit = 50  # Reduce items per page to avoid rate limiting
    
    # Add CSRF token acquisition
    session = requests.Session()
    session.get("https://leetcode.cn/problemset/all/", headers=HEADERS)
    
    while True:
        variables = {
            "categorySlug": "",
            "skip": page * limit,
            "limit": limit,
            "filters": {}
        }
        payload = {
            "operationName": "problemsetQuestionList",
            "query": QUESTION_LIST_QUERY,
            "variables": variables
        }
        
        try:
            response = session.post(
                GRAPHQL_URL, 
                json=payload, 
                headers=HEADERS,
                timeout=15
            )
            
            # Check response status
            if response.status_code != 200:
                print(f"Error status code: {response.status_code}, Response content: {response.text[:200]}")
                break
                
            data = response.json()
            
            # Check for GraphQL errors
            if "errors" in data:
                print(f"GraphQL error: {data['errors']}")
                break
                
            if "data" not in data:
                print(f"Missing data in response: {data}")
                break
                
            question_list = data["data"]["problemsetQuestionList"]["questions"]
            if not question_list:
                break
                
            # Filter out paid problems
            free_problems = [q for q in question_list if not q.get("paidOnly")]
            problems.extend(free_problems)
            
            print(f"Retrieved page {page+1}, got {len(free_problems)} free problems")
            page += 1
            
            # Add delay to avoid being blocked
            time.sleep(1.5)
            
        except Exception as e:
            print(f"Error occurred while fetching problems: {str(e)}")
            break
    
    return problems

# Other functions remain unchanged (but use the same session object)...

if __name__ == "__main__":
    import time  # New import
    main()